class AssetsController < ApplicationController

  # Render images

  def logo
    business = Business.find(params[:id].to_i)
    

    if business.logo
              
      send_data business.logo.download,
      type: business.logo.attachment.blob.content_type,
      disposition: 'inline'
    end
  end
  
  def avatar
    if params[:id]
      user = User.joins(:avatar_attachment).where("active_storage_attachments.blob_id = ?", params[:id]).first

      if user.avatar.present?
        
        send_data user.avatar.download,
        type: user.avatar.attachment.blob.content_type,
        disposition: 'inline'
      end
    end
  end
end
