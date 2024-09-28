Class {
	#name : #LcsMenuSubgroupDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuItems'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #'menu items' }
LcsMenuSubgroupDefinition >> addMenuItem: aMenuItem [
	aMenuItem parent: self.
	self menuItems add: aMenuItem
]

{ #category : #'as yet unclassified' }
LcsMenuSubgroupDefinition >> componentName [
	^ self parent componentName , 'Submenu'
]

{ #category : #initialize }
LcsMenuSubgroupDefinition >> initialize [ 
	super initialize.
	self menuItems: OrderedCollection new
]

{ #category : #accessing }
LcsMenuSubgroupDefinition >> menuItems [
	^ menuItems
]

{ #category : #accessing }
LcsMenuSubgroupDefinition >> menuItems: anObject [
	menuItems := anObject
]
