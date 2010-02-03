<?php

function __autoload($class)
{
	switch (true) {
	case (strpos($class, 'Lexer') !== false):
		$file = 'tokenizers/' . strtolower(str_replace('Lexer', '', $class)) . '.php';
		break;
	case (in_array($class, array('Inflector', 'Highlighter', 'SynfileParser', 'CssHelper'))):
		$file = 'util/' . $class . '.php';
		break;
	}

	require_once($file);
}
