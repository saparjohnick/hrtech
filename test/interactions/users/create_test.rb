require "test_helper"

class Users::CreateTest < ActiveSupport::TestCase
  test 'positive case' do
    valid_params = {
      'name' => 'John',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'john.doe@example.com',
      'age' => 30,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'male',
      'interests' => 'coding,reading',
      'skills' => 'ruby,rails'
    }
    result = Users::Create.run(params: valid_params)

    assert result.result.is_a?(User)
    assert_equal 2, result.result.skills.count
    assert_equal 2, result.result.interests.count
  end

  test 'invalid email' do
    existing_user = User.create!(
      name: 'Jane',
      surname: 'Doe',
      patronymic: 'Smith',
      email: 'jane.doe@example.com',
      age: 25,
      nationality: 'American',
      country: 'USA',
      gender: 'female'
    )

    invalid_params = {
      'name' => 'John',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'jane.doe@example.com',
      'age' => 30,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'male',
      'interests' => 'coding,reading',
      'skills' => 'ruby,rails'
    }

    result = Users::Create.run(params: invalid_params)

    assert_not result.result.present?
  end

  test 'invalid age' do
    invalid_params = {
      'name' => 'John',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'john.doe@example.com',
      'age' => -1,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'male',
      'interests' => 'coding,reading',
      'skills' => 'ruby,rails'
    }

    result = Users::Create.run(params: invalid_params)

    assert_not result.result.present?
  end

  test 'invalid gender' do
    invalid_params = {
      'name' => 'John',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'john.doe@example.com',
      'age' => 30,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'unknown',
      'interests' => 'coding,reading',
      'skills' => 'ruby,rails'
    }

    result = Users::Create.run(params: invalid_params)

    assert_not result.result.present?
  end

  test 'missing required fields' do
    invalid_params = {
      'name' => '',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'john.doe@example.com',
      'age' => 30,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'male',
      'interests' => 'coding,reading',
      'skills' => 'ruby,rails'
    }

    result = Users::Create.run(params: invalid_params)

    assert_not result.result.present?
  end

  test 'invalid skills' do
    invalid_params = {
      'name' => 'John',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'john.doe@example.com',
      'age' => 30,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'male',
      'interests' => 'coding,reading',
      'skills' => ''
    }

    result = Users::Create.run(params: invalid_params)

    assert_not result.result.present?
  end

  test 'duplicated skills' do
    invalid_params = {
      'name' => 'John',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'john.doe@example.com',
      'age' => 30,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'male',
      'interests' => 'coding,reading',
      'skills' => 'ruby,ruby'
    }

    result = Users::Create.run(params: invalid_params)

    assert_equal 1, result.result.skills.count
  end

  test 'invalid interests' do
    invalid_params = {
      'name' => 'John',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'john.doe@example.com',
      'age' => 30,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'male',
      'interests' => '',
      'skills' => 'ruby,rails'
    }

    result = Users::Create.run(params: invalid_params)

    assert_not result.result.present?
  end

  test 'duplicated interests' do
    invalid_params = {
      'name' => 'John',
      'surname' => 'Doe',
      'patronymic' => 'Smith',
      'email' => 'john.doe@example.com',
      'age' => 30,
      'nationality' => 'American',
      'country' => 'USA',
      'gender' => 'male',
      'interests' => 'coding,coding',
      'skills' => 'ruby,rails'
    }

    result = Users::Create.run(params: invalid_params)

    assert_equal 1, result.result.interests.count
  end
end
