module PhotosHelper
  def next_photo_index(counter, picture_count)
    if counter == picture_count
      1
    else
      counter + 1
    end
  end

  def prev_photo_index(counter, picture_count)
    if counter == 1
      picture_count
    else
      counter - 1
    end
  end
end
