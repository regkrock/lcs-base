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
LcsSlotModelViewItem >> children [
	self item isCollection ifFalse: [ ^ #()].
	self item isEmpty ifTrue: [ ^ {} ].
	^ (self item select: [ :each | each respondsTo: self childrenSelector ])
		collect: [ :each | each  perform: self childrenSelector ]
]
