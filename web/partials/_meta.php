<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">

<title><?php wp_title( '' ); ?> | <?php bloginfo('name'); ?></title>
<link rel="profile" href="http://gmpg.org/xfn/11" />
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>" />

<link rel="stylesheet" href="<?php echo get_stylesheet_directory_uri(); ?>/assets/css/main.css">
<link href='http://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic|Open+Sans:800' rel='stylesheet' type='text/css'>

<link rel="shortcut icon" href="<?php echo get_stylesheet_directory_uri(); ?>/favicon.png" />
<link rel="apple-touch-icon" href="<?php echo get_stylesheet_directory_uri(); ?>/touch-icon-iphone.png">
<link rel="apple-touch-icon" sizes="76x76" href="<?php echo get_stylesheet_directory_uri(); ?>/touch-icon-ipad.png">
<link rel="apple-touch-icon" sizes="120x120" href="<?php echo get_stylesheet_directory_uri(); ?>/touch-icon-iphone-retina.png">
<link rel="apple-touch-icon" sizes="152x152" href="<?php echo get_stylesheet_directory_uri(); ?>/touch-icon-ipad-retina.png">

<meta property="og:url" content="<?php the_permalink() ?>"/>  
<meta property="og:title" content="<?php single_post_title(''); ?>" />  
<meta property="og:description" content="<?php echo strip_tags(get_the_excerpt($post->ID)); ?>" />  
<meta property="og:type" content="article" />  
<meta property="og:site_name" content="<?php bloginfo('name'); ?>" />  
<meta property="og:image" content="<?php echo get_stylesheet_directory_uri(); ?>/assets/images/og-image.png"/>

<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<?php wp_head(); ?>
<?php get_template_part('partials/_analytics'); ?>