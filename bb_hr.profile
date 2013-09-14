<?php

function bb_hr_install_tasks($install_state) {
  return array(
    'bb_hr_set_default_language' => array(
      'display_name' => 'Standaardtaal instellen',
      'display' => TRUE,
      'type' => 'normal',
      'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    ),
    'bb_hr_add_homepage' => array(
      'display_name' => 'Maak een homepage',
      'display' => TRUE,
      'type' => 'normal',
      'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    ),
    'bb_hr_extra_configurations' => array(
      'display_name' => 'Extra configuraties',
      'display' => TRUE,
      'type' => 'normal',
      'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    ),
  );
}

function bb_hr_set_default_language(&$install_state) {
  // set Dutch as default language
  $languages = language_list();
  variable_set('language_default', $languages['nl']);
}


function bb_hr_add_homepage(&$install_state) {

	$bodytext = "Homepage";
	
	$node = new stdClass(); // Create a new node object
	$node->type = "page"; // Or page, or whatever content type you like
	node_object_prepare($node); // Set some default values
	
	$node->title    = "Homepage";
	//$node->language = LANGUAGE_NONE; // Or e.g. 'en' if locale is enabled
        $node->language = 'nl';

	$node->uid = 1; // UID of the author of the node; or use $node->name
	
	$node->body[$node->language][0]['value']   = $bodytext;
	$node->body[$node->language][0]['summary'] = text_summary($bodytext);
	$node->body[$node->language][0]['format']  = 'filtered_html';
	
	$node->path = array('alias' => 'home');
	
	if($node = node_submit($node)) { // Prepare node for saving
    node_save($node);
	}  

  variable_set('site_frontpage', 'node/1');
}

function bb_hr_extra_configurations(&$install_state) {

  // extra variables to be set
  
  // autopath pattern for nodes
  variable_set('pathauto_node_pattern', '[node:title]');
  
  // default theme
  theme_enable(array('zen', 'brightbrain'));
  variable_set('theme_default', 'brightbrain');

  // webform variables: hide comments and submitted by text
  variable_set('comment_webform', 0);
  variable_set('node_submitted_webform', 0);

}
