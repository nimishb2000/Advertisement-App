class AdRepresenter
  def initialize(ads)
    @ads = ads
  end

  def to_json(ads)
    ads.map do |ad|
      {
        title: ad.title,
        desc: ad.desc,
        creator_name: creator_name(ad),
        uploaded_on: ad.created_at
      }
    end
  end

  private
  attr_reader :ads

  def creator_name(ad)
    "#{ad.user.first_name} #{ad.user.last_name}"
  end
end
