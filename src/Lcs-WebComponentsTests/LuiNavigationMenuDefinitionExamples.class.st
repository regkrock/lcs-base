Class {
	#name : 'LuiNavigationMenuDefinitionExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> navigationMenuDefinition [
	<gtExample>
	| menuDefinition |
	menuDefinition := self newDefinition.
	menuDefinition componentName: 'navigationMenu'.
	self assert: menuDefinition componentName = 'navigationMenu'.
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> navigationMenuWith3Submenus [
	<gtExample>
	| menuDefinition |
	menuDefinition := self navigationMenuDefinition.
	menuDefinition addDefinition: (LuiSubmenuDefinitionExamples new menu1DefinitionWith3Submenus).
	menuDefinition addDefinition: (LuiSubmenuDefinitionExamples new menu2DefinitionWith2Submenus).
	menuDefinition addDefinition: (LuiSubmenuDefinitionExamples new menu3Definition3SubmenuLevels).
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> navigationMenuWithThreeMenuItemDefinitions [
	<gtExample>
	| menuDefinition |
	menuDefinition := self navigationMenuDefinition.
	menuDefinition
		addDefinition: (
			LuiMenuItemDefinition new 
				label: 'Home';
				beAnchor;
				title: 'Go to Home';
				yourself);
		addDefinition: (LuiMenuItemDefinition new label: 'Contact');
		addDefinition: (LuiMenuItemDefinition new label: 'About').
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> newDefinition [
	<gtExample>
	| menuDefinition |
	menuDefinition := LuiNavigationMenuDefinition new.
	self assert: menuDefinition cssClasses isEmpty.
	self assert: menuDefinition menuComponentDefintions isEmpty.
	self assert: menuDefinition componentName isNil.
	self assert: menuDefinition parent isNil.
	^ menuDefinition
]
