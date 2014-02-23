<form role="search" method="get" class="search-form" action="<?php echo home_url( '/' ); ?>">
    <label>
        <input type="search" class="search-field" placeholder="Search …" value="<?php the_search_query(); ?>" name="s" title="Search for:" />
    </label>
    <button type="submit" class="search-submit" value="Search" ><i class="icon-search""></i></button>
</form>