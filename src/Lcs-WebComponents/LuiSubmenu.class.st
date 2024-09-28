Class {
	#name : #LuiSubmenu,
	#superclass : #LuiMenuObject,
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #building }
LuiSubmenu >> buildFrom: aSubenuDefinition [
	aSubenuDefinition menuItems do: [ :eachMenuDefinition | 
		| menuItemComponent |
		menuItemComponent := LuiMenuItem named: eachMenuDefinition componentName on: self.
		self addComponent: menuItemComponent.
		menuItemComponent buildFrom: eachMenuDefinition]
]

{ #category : #rendering }
LuiSubmenu >> renderComponentOn: html [
	super renderComponentOn: html.
	"html div
		id: self componentId;
		class: self cssClassesString
		with: [
			html text: self menuName asString.
			self components do: [ :eachComponent |
				html render: eachComponent ] ]"
]
