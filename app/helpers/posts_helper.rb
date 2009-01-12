module PostsHelper
  def columnizer(characters)
      case
      when characters > 1500
        'three-col'
      when characters > 500
        'two-col'
      else characters < 500
        'one-col'
      end
  end
  

end
