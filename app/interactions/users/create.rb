class Users::Create < ActiveInteraction::Base
  hash :params do
    string :name
    string :surname
    string :patronymic
    string :email
    integer :age
    string :nationality
    string :country
    string :gender
    string :interests
    string :skills
  end

  def to_model
    User.new
  end

  def execute
    is_all_params_present = params.values.all?(&:present?)
    is_email_valid = User.where(email: params['email']).empty?
    is_age_valid = params['age'] > 0 && params['age'] <= 90
    is_gender_valid = params['gender'].in?(User.gender.values)

    return unless is_all_params_present && is_email_valid && is_age_valid && is_gender_valid

    user_full_name = "#{params['surname']} #{params['name']} #{params['patronymic']}"
    user_params = params.except('interests', 'skills')
    user = User.new(
      name: user_params['name'],
      surname: user_params['surname'],
      email: user_params['email'],
      patronymic: user_params['patronymic'],
      age: user_params['age'],
      nationality: user_params['nationality'],
      country: user_params['country'],
      gender: user_params['gender'],
      full_name: user_full_name
    )

    parsed_interests = params['interests'].split(',').map(&:strip).reject(&:empty?).uniq
    parsed_skills = params['skills'].split(',').map(&:strip).reject(&:empty?).uniq
    interests = parsed_interests.map { |name| Interest.find_or_create_by!(name: name) }
    skills = parsed_skills.map { |name| Skill.find_or_create_by!(name: name) }

    return unless interests.all?(&:valid?) && skills.all?(&:valid?)

    user.skills = skills
    user.interests = interests

    return unless user.save

    user
  end
end
