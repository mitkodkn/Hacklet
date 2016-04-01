# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
     # For Rails 3.1+ asset pipeline compatibility:
      ActionController::Base
        .helpers
        .asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))

     "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  process :resize_to_fit => [200, 200]

  version :thumb do
    process :resize_to_fit => [100, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
