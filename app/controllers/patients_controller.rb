class PatientsController < ApplicationController

  def new
    @patient = Patient.new
  end

  def edit
    @patient = Patient.get_patient(params[:id])
  end

  def create
    #binding.pry
    patient = Patient.new(patient_params)
    patient.disease = Disease.new(description: disease_params[:disease_description])

    if patient.valid?
      #patient.
      current_user.patients << patient
      redirect_to my_patient_path
    end
  end

  def destroy
    patient = Patient.where(id: params[:id]).first
    if patient
      patient.destroy
      #redirect_to my_patient_path
    end
  end

  def update
    @patient = Patient.where(id: params[:id]).first

    disease = @patient.disease
    disease.description = disease_params[:disease_description]

    #disease.assign_attributes({:description => disease_params[:disease_description] })

    if @patient.update_attributes(patient_params)
      flash[:success] = "Profile Updated."
    else
      flash[:success] = "Error Occoured."
    end
    redirect_to my_patient_path
  end

  private

  def my_patient_path
    my_patients_member_path(current_user)
  end
  def patient_params
    params.require(:patient).permit(:name, :phone, :address)
    # params.merge({user_id: current_user.id})
  end

  def disease_params
    params.require(:patient).permit(:disease_description)
  end

end

