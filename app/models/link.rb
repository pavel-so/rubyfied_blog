class Link < ActiveRecord::Base
  validates :href,
            :presence=>true,
            :uniqueness=>true,
            :format=>
              {:with=> /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/,
               :message => "Wrong url format"}
  validates :position,
            :presence=>true
  validates :title,
            :presence=>true

  def initialize(params={})
    super(params)
    max=Link.maximum(:position)||0
    self.position=max+1
  end
  def is_top?
    position==Link.minimum(:position)
  end

  def is_bottom?
    position==Link.maximum(:position)
  end
  def move_up
    top_link=Link.where('position < :position',:position=>self.position).order("position ASC").first
    Link.swap_position(top_link,self)
  end
  def move_down
    bottom_link=Link.where('position > :position',:position=>self.position).order("position DESC").first
    Link.swap_position(bottom_link,self)
  end
  protected
  def self.swap_position(first,second)
    tmp_pos=second.position
    second.position= first.position
    first.position=tmp_pos
    first.save && second.save
  end
end

