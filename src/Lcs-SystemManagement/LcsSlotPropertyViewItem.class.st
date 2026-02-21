Class {
	#name : 'LcsSlotPropertyViewItem',
	#superclass : 'LcsViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'defaults' }
LcsSlotPropertyViewItem class >> defaultChildrenSelector [
	^ #slotPropertiesViewItems
]

{ #category : 'children' }
LcsSlotPropertyViewItem >> itemChildrenForNonresponders [
	self item isString ifTrue: [ ^ #() ].
	self item isCollection ifTrue: [ ^ self item collect: [ :each | LcsSlotModelViewItem newLabel: '' item: each ] ].
	^ super itemChildrenForNonresponders
]
