<nav class="sidebar">
    <?php get_search_form(); ?>

    <?php wp_nav_menu( array( 'theme_location' => 'sidebar-menu-1' ) ); ?>

    <?php if ( is_active_sidebar( 'sidebar-1' ) ) : ?>
        <div class="first ">
            <?php dynamic_sidebar( 'sidebar-1' ); ?>
        </div>
    <?php endif; ?>

    <?php if ( is_active_sidebar( 'sidebar-2' ) ) : ?>
        <div class="second">
            <?php dynamic_sidebar( 'sidebar-2' ); ?>
        </div>
    <?php endif; ?>
</nav>