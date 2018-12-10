module TracksHelper

    def getLikeIcon(id, likes)
        #h = '<i class="fa fa-heart icon"></i><span class="votes-count" data-id="' + id +'">' + likes + '</span>'
        #txt =  "<i class='fa fa-heart icon'></i>  &nbsp;  <span class='votes-count' data-id='#{id}'>#{likes}</span>"
        txt =  "<i class='fa fa-heart icon'></i>  &nbsp; "
        return txt.html_safe
    end

end
