module TwetsHelper

  def twet_content_tag(tag, content)
    content_tag(tag, sub_usernames(content).html_safe)
  end

  # Returns true / false indicating whether the twet passed can be
  # retweted by the authenticated user.
  #
  def can_retwet(twet)
    if twet.user_id == current_user.id
      return false
    elsif has_retweted(twet)
      return false
    else
      return true
    end
  end

  # Returns true / false indicating whether the authenticated user
  # has already retweted the twet passed.
  #
  def has_retweted(twet)
    retwet(twet).present? ? true : false
  end

  # Returns the actual retwet instance created by the authenticated user for
  # the twet passed
  #
  def retwet(twet)
    current_user.retwets.where(:twet_id => twet.id).first
  end

  protected

  def sub_usernames(content)
    content.gsub(/\@([a-zA-z]+\b)/) { |match|
      link_to("#{match}", twets_view_user_path("#{match.from(1)}"))
    }
  end
end
