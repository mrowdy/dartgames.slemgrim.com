<article class="whitebox article" id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
    <h1 class="title"><?php the_title(); ?></h1>
    <div class="excerpt">
        <?php the_content(); ?>
    </div>
    <?php get_template_part('partials/_share'); ?>
    <?php get_template_part('partials/_disqus'); ?>
</article>