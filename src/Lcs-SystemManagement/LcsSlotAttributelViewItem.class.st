Class {
	#name : 'LcsSlotAttributelViewItem',
	#superclass : 'LcsViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'defaults' }
LcsSlotAttributelViewItem class >> defaultChildrenSelector [
	^ #slotAttributeViewItems
]

{ #category : 'children' }
LcsSlotAttributelViewItem >> children [
	self item isString ifTrue: [ ^ #() ].
	self item isCollection ifTrue: [ ^ self item collect: [ :each | LcsSlotModelViewItem newLabel: '' item: each ] ].
	(self item respondsTo: self childrenSelector) ifTrue: [
		^ self item  perform: self childrenSelector ].
	^ #()
]
