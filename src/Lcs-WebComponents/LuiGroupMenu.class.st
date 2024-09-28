Class {
	#name : #LuiGroupMenu,
	#superclass : #LuiMenuObject,
	#instVars : [
		'name'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #building }
LuiGroupMenu >> buildFrom: aGroupMenuDefinition [
	self name: aGroupMenuDefinition menuName.
	aGroupMenuDefinition menuItems do: [ :eachMenuDefinition | 
		| menuItemComponent |
		menuItemComponent := LuiMenuItem named: eachMenuDefinition componentName on: self.
		self addComponent: menuItemComponent.
		menuItemComponent buildFrom: eachMenuDefinition]
]

{ #category : #defaults }
LuiGroupMenu >> defaultCssClasses [
	^OrderedCollection with: 'subnav'
]

{ #category : #accessing }
LuiGroupMenu >> name [
	^ name
]

{ #category : #accessing }
LuiGroupMenu >> name: anObject [
	name := anObject
]

{ #category : #rendering }
LuiGroupMenu >> renderComponentOn: html [
	super renderComponentOn: html.
	html div
		id: self componentId;
		class: self cssClassesString;
		with: [
			html button
				id: self componentId , '_button';
				class: 'subnavbtn';
				text: self name asString.
			html div
				id: 'item';
				class: 'subnav-content';
				with: [
						self components do: [ :eachComponent | html render: eachComponent ] ] ]
]
