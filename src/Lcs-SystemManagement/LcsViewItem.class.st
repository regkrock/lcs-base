Class {
	#name : #LcsViewItem,
	#superclass : #LcsObject,
	#traits : 'LtApplicationEnvironment',
	#classTraits : 'LtApplicationEnvironment classTrait',
	#instVars : [
		'label',
		'item',
		'childrenSelector'
	],
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #defaults }
LcsViewItem class >> defaultChildrenSelector [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
LcsViewItem class >> newLabel: aString item: anObject [ 
	^ self new
		initializeLabel: aString value: anObject;
		yourself
]

{ #category : #children }
LcsViewItem >> children [
	^ self itemChildren: self childrenSelector
]

{ #category : #accessing }
LcsViewItem >> childrenSelector [
	^ childrenSelector
]

{ #category : #accessing }
LcsViewItem >> childrenSelector: anObject [
	childrenSelector := anObject
]

{ #category : #defaults }
LcsViewItem >> defaultChildrenSelector [
	^ self class defaultChildrenSelector
]

{ #category : #initialize }
LcsViewItem >> initialize [
	super initialize.
	self childrenSelector: self defaultChildrenSelector
]

{ #category : #initialize }
LcsViewItem >> initializeLabel: aString value: anObject [ 
	self 
		label: aString;
		item: anObject
]

{ #category : #accessing }
LcsViewItem >> item [
	^ item
]

{ #category : #accessing }
LcsViewItem >> item: anObject [
	item := anObject
]

{ #category : #children }
LcsViewItem >> itemChildren: anItemChildrenSelector [
	^ (self item respondsTo: anItemChildrenSelector)
		ifTrue: [ self item perform: anItemChildrenSelector ]
		ifFalse: [ #() ]
]

{ #category : #accessing }
LcsViewItem >> label [
	^ label
]

{ #category : #accessing }
LcsViewItem >> label: anObject [
	label := anObject
]
