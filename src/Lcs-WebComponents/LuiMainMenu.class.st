Class {
	#name : #LuiMainMenu,
	#superclass : #LuiMenuObject,
	#instVars : [
		'menuItems'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #building }
LuiMainMenu >> buildFrom: aGroupMenuDefinition [
	aGroupMenuDefinition menuGroups do: [ :eachMenuGroup | 
		| menuGroupComponent |
		menuGroupComponent := LuiGroupMenu named: eachMenuGroup componentName on: self.
		self addComponent: menuGroupComponent.
		menuGroupComponent buildFrom: eachMenuGroup]
]

{ #category : #defaults }
LuiMainMenu >> defaultCssClasses [
	^OrderedCollection with: 'navbar'
]

{ #category : #rendering }
LuiMainMenu >> renderComponentOn: html [
	super renderComponentOn: html.
	html div
		id: self componentId;
		class: self cssClassesString;
		with: [
			self components do: [ :eachComponent |
				html render: eachComponent ] ]
		

]
