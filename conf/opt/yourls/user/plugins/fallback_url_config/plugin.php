<?php
/*
Plugin Name: Fallback URL
Plugin URI: http://diegopeinador.com/fallback-url-yourls-plugin
Description: This plugin allows you to define a fallback URL in case there isn't a match for your short URL, so you can specify something different than $YOURLS_HOME.
Version: 1.0
Author: Diego Peinador
Author URI: http://diegopeinador.com
*/

// No direct call
if( !defined( 'YOURLS_ABSPATH' ) ) die();

yourls_add_action( 'redirect_keyword_not_found', 'dp_fallback_url' );
function dp_fallback_url() {
        // Get value from database
        $fallback_url = yourls_get_option( 'fallback_url' );
	yourls_redirect( $fallback_url, 302 ); //Use a temporal redirect in case there is a valid keyword in the future
}

// Register our plugin config page
yourls_add_action( 'plugins_loaded', 'dp_config_add_page' );
function dp_config_add_page() {
        yourls_register_plugin_page( 'fallback_url_config', 'Fallback URL Plugin Config', 'dp_config_do_page' );
        // parameters: page slug, page title, and function that will display the page itself
}

// Display config page
function dp_config_do_page() {

        // Check if a form was submitted
        if( isset( $_POST['fallback_url'] ) )
                dp_config_update_option();

        // Get value from database
        $fallback_url = yourls_get_option( 'fallback_url' );

        echo <<<HTML
                <h2>Fallback URL Plugin Config</h2>
                <p>Here you can configure the URL to redirect in case the keyword is not found in database.</p>
                <form method="post">
                <p><label for="fallback_url">URL to fallback to</label> <input type="text" id="fallback_url" name="fallback_url" value="$fallback_url" size="40" /></p>
                <p><input type="submit" value="Update value" /></p>
                </form>
HTML;
}

// Update option in database
function dp_config_update_option() {
        $in = $_POST['fallback_url'];

        if( $in ) {
                // Validate test_option. ALWAYS validate and sanitize user input.
                // Here, we want an string
                $in = strval( $in);

                // Update value in database
                yourls_update_option( 'fallback_url', $in );
        }
}
