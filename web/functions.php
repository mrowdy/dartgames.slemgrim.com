<?php

error_reporting(E_ALL);
ini_set("display_errors", 1);

new Dartgames();

class Dartgames{

    public function __construct(){
        add_action('after_setup_theme', array($this, 'setup'));
        add_action('widgets_init', array($this, 'widgets_init'));
        add_action('init', array($this, 'register_menues'));
        add_filter('image_send_to_editor', array($this, 'linked_images_class'), 10, 9);
        add_filter('tablepress_use_default_css', '__return_false');
    }

    public function setup() {
        load_theme_textdomain('dartgames', get_template_directory() . '/languages' );
        add_theme_support('automatic-feed-links' );
        add_theme_support('menus' );
        add_theme_support('html5', array('search-form'));

    }

    public function register_menues() {
        register_nav_menus(
            array(
                'sidebar-menu-1' => __( 'Sidebar Menu 1' ),
                'sidebar-menu-2' => __( 'Sidebar Menu 2' ),
            )
        );
    }


    public function widgets_init(){
        register_sidebar( array(
            'name' => __( 'Main Sidebar', 'dartgames' ),
            'id' => 'sidebar-1',
            'description' => __( 'Appears on posts and pages except the optional Front Page template, which has its own widgets', 'dartgames' ),
            'before_widget' => '<aside id="%1$s" class="widget %2$s">',
            'after_widget' => '</aside>',
            'before_title' => '<h3 class="widget-title">',
            'after_title' => '</h3>',
        ) );

        register_sidebar( array(
            'name' => __( 'Second Front Page Widget Area', 'dartgames' ),
            'id' => 'sidebar-2',
            'description' => __( 'Appears when using the optional Front Page template with a page set as Static Front Page', 'dartgames' ),
            'before_widget' => '<aside id="%1$s" class="widget %2$s">',
            'after_widget' => '</aside>',
            'before_title' => '<h3 class="widget-title">',
            'after_title' => '</h3>',
        ) );
    }

    public function linked_images_class($html, $id, $caption, $title, $align, $url, $size, $alt = '' ){
        $classes = 'img';
        if ( preg_match('/<a.*? class=".*?">/', $html) ) {
            $html = preg_replace('/(<a.*? class=".*?)(".*?>)/', '$1 ' . $classes . '$2', $html);
        } else {
            $html = preg_replace('/(<a.*?)>/', '$1 class="' . $classes . '" >', $html);
        }

        return $html;
    }
}

