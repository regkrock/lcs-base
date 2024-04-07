Class {
	#name : #LcsViewItem,
	#superclass : #LcsObject,
	#instVars : [
		'label',
		'item',
		'childrenSelector'
	],
	#category : #LcsBase
}

{ #category : #default }
LcsViewItem class >> defaultChildrenSelector [
	^ #pleaseDefineChildrenSelector
]

{ #category : #'instance  creation' }
LcsViewItem class >> newLabel: aString item: anObject [ 
	^ self new
		initializeLabel: aString value: anObject;
		yourself
]

{ #category : #children }
LcsViewItem >> children [
	^self itemChildren: self childrenSelector
]

{ #category : #children }
LcsViewItem >> childrenSelector [
	^childrenSelector
]

{ #category : #accessing }
LcsViewItem >> childrenSelector: anObject [
	childrenSelector := anObject
]

{ #category : #default }
LcsViewItem >> defaultChildrenSelector [
	^ self class defaultChildrenSelector
]

{ #category : #initalize }
LcsViewItem >> initialize [
	super initialize.
	self childrenSelector: self defaultChildrenSelector
]

{ #category : #'instance  creation' }
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
