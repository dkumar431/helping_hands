class Patient < ActiveRecord::Base
  belongs_to :user
  has_one :disease, dependent: :destroy

  delegate :description, to: :disease, prefix: true, allow_nil: true

  # attr_accessor :disease_description
  validates_presence_of :name

  def self.get_patient(patient_id)
    Patient.joins(:disease)
    .select('patients.*,diseases.description')
    .where('patients.id = ?',patient_id).first
  end


end
