Class {
	#name : 'LcsSlotModelViewItem',
	#superclass : 'LcsViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'defaults' }
LcsSlotModelViewItem class >> defaultChildrenSelector [
	^ #gtViewSlotModelChildren
]

{ #category : 'children' }
LcsSlotModelViewItem >> itemChildrenForNonresponders [
	self item isCollection ifFalse: [ ^ #()].
	self item isEmpty ifTrue: [ ^ #() ].
	^ super itemChildrenForNonresponders
]
