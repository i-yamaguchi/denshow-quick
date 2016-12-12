class RequestDetail < ActiveRecord::Base
  belongs_to :request_application
  belongs_to :doc_type
  belongs_to :chg_type

  before_validation do
    %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln vendor_code).each do |attribute|
      send(attribute).upcase! if send(attribute).present?
    end
  end

  INVALID_REGEX = /\p{Hiragana}|[ァ-ン]|[ー－]|[一-龠々]|[Ａ-Ｚ]|[０-９]/

  # TODO: rspecセットアップ後にvalidateのテストコードを書くこと
  %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln).each do |attribute|
    validates attribute, length: { maximum: 255 }, format: { without: INVALID_REGEX }
  end

  validates :doc_type_id, presence: true

  # TODO: rspecセットアップ後にvalidateのテストコードを書くこと
  validates :vendor_code, length: { maximum: 255 }, format: { without: /[^0-9^A-Z]/ }
end
