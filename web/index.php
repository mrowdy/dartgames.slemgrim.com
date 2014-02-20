<!--[if IE 7]>
<html class="ie ie7" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 8]>
<html class="ie ie8" <?php language_attributes(); ?>>
<![endif]-->
<!--[if !(IE 7) | !(IE 8)  ]><!-->
<html <?php language_attributes(); ?>>
<!--<![endif]-->
    <head>
        <?php get_template_part('partials/_meta'); ?>
    </head>
    <body <?php body_class(); ?>>
        <div class="outer">

            <?php get_header(); ?>

            <div class="container columns">
                <div class="left-col">
                    <div class="hero"></div>

                    <ul class="article-list">
                        <?php if ( have_posts() ) : ?>
                            <?php while ( have_posts() ) : the_post(); ?>
                                <li>
                                    <?php get_template_part('partials/_article'); ?>
                                </li>
                            <?php endwhile; ?>
                        <?php else : ?>
                            <li>
                               no posts
                            </li>
                        <?php endif; ?>
                    </ul>
                    <?php get_template_part('partials/_pagination'); ?>
                </div>
                <div class="right-col">
                    <?php get_sidebar(); ?>
                </div>
            </div>
        </div>
        <script type="application/dart" src="<?php echo get_stylesheet_directory_uri(); ?>/main.dart"></script>
        <script src="<?php echo get_stylesheet_directory_uri(); ?>/packages/browser/dart.js"></script>
        <?php wp_footer(); ?>
    </body>
</html>