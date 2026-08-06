Class {
	#name : 'LuiTable',
	#superclass : 'LuiTableObjectComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiTable class >> onSlot: aSlotDefinition model: aModel [ 
	^ self
		onSlot: aSlotDefinition
		model: aModel
		componentName: aSlotDefinition slotName , 'Table'
]

{ #category : 'components - creation' }
LuiTable >> buildTable [
	self addComponent: (LuiTableCaption onSlotNamed: 'caption' model: self valueAccessor read).
	"self addComponent: (LuiTableHeader onSlotNamed: 'columnTitles' model: self valueAccessor read)"
	
]

{ #category : 'rendering' }
LuiTable >> renderComponentOn: html [
	html table
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'components' }
LuiTable >> tableRoot [
	^ self
]
