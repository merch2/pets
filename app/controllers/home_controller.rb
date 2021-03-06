class HomeController < ApplicationController
  
  def index
    @blogs = Blog.where("created_at < ?", Time.now).where(del: false).where("body_size > ?", 300).order("Rand()")
    @blogs = @blogs.joins(:blog_attachments).group('blogs.id').having("count(blog_attachments.id) > ?", 1).order('Rand()').limit(6)
    @articles = Article.where("created_at < ?", Time.now).order("created_at DESC").limit(6)
    @pet_day = Winner.last.user.mypets.where("pet_attachments_count > 0").sample if Winner.count > 1
    @pets = Mypet.where("pet_attachments_count > 0").order("Rand()").limit(12)
    if current_user && current_user.city
      @pets_city = current_user.city.mypets.where("pet_attachments_count > 0").order("Rand()").limit(12)
    end
  end


  def refresh
    @pets = Mypet.where("photo_file_name NOT IN (?)", "nil").order("Rand()").limit(12)
  end

  def weekly
    @top5 = User.order("repa DESC").limit(5)
    @winners = Winner.all
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :country, :sex, :nickname, :birthday, :avatar, :crop_x, :crop_y, :crop_w, :crop_h)
  end
  
  def breed_params
    params.require(:breed).permit(:name, :breed_type, :translate)
  end
  

  
end
