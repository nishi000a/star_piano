class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource
    when Admin
        admin_root_path
    when Teacher
        teacher_root_path
    when Student
        student_root_path
    end
  end


  def after_sign_up_path_for(resource)
    case resource
    when Teacher
      teacher_root_path
    when Student
      student_root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      new_student_session_path
    end


  end

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation])
  end

end