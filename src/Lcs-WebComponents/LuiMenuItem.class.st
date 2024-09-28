Class {
	#name : #LuiMenuItem,
	#superclass : #LuiMenuObject,
	#instVars : [
		'menuName'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #building }
LuiMenuItem >> buidlSubmenuFrom: aSubmenuDefinition [
	| submenuComponent |
	submenuComponent := LuiSubmenu
			named: aSubmenuDefinition componentName
			on: self.
	self addComponent: submenuComponent.
	^ submenuComponent buildFrom: aSubmenuDefinition
]

{ #category : #building }
LuiMenuItem >> buildFrom: aMenuItemDefinition [
	self menuName: aMenuItemDefinition menuName.
	aMenuItemDefinition submenu
		ifNotNil: [ self buidlSubmenuFrom: aMenuItemDefinition submenu]
]

{ #category : #accessing }
LuiMenuItem >> menuName [
	^ menuName
]

{ #category : #accessing }
LuiMenuItem >> menuName: anObject [
	menuName := anObject
]

{ #category : #rendering }
LuiMenuItem >> renderComponentOn: html [
	super renderComponentOn: html.
	html div
		id: self componentId;
		class: self cssClassesString;
		with: [
			html text: self menuName asString.
			self components do: [ :eachComponent |
				html render: eachComponent ] ]
]
