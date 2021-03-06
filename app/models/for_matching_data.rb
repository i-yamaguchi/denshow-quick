class ForMatchingData < ActiveRecord::Base
  include ForMatchingData::Matcher

  %i(format_type document_no model_code doc_no doc_type_str sht rev eo_chgno chg_type_str mcl scp_for_smpl scml revision).each do |attribute|
    validates attribute, length: { maximum: 255 }
  end

  validates :document_no, uniqueness: true
end
