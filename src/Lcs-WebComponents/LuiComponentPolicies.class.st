Class {
	#name : #LuiComponentPolicies,
	#superclass : #Object,
	#instVars : [
		'policies',
		'parent'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance creation' }
LuiComponentPolicies class >> on: anObject [
	^ self new 
		initializeOn: anObject;
		yourself 
]

{ #category : #initialize }
LuiComponentPolicies >> addPolicy: aComponentPolicy [
	self policies at: aComponentPolicy policyName put: aComponentPolicy
]

{ #category : #'as yet unclassified' }
LuiComponentPolicies >> fullComponentNameWithId [
	^ self parent fullComponentNameWithId
]

{ #category : #initialize }
LuiComponentPolicies >> initialize [
	super initialize.
	self policies: Dictionary new.
]

{ #category : #initialize }
LuiComponentPolicies >> initializeOn: aComponent [ 
	self parent: aComponent.
	self addPolicy: (LuiVisibilityPolicy on: self)
]

{ #category : #'as yet unclassified' }
LuiComponentPolicies >> isHidden [
	^ self isVisiblePolicy isHidden
]

{ #category : #'as yet unclassified' }
LuiComponentPolicies >> isVisible [
	^(self policyNamed: 'isVisible') isVisible
]

{ #category : #policies }
LuiComponentPolicies >> isVisiblePolicy [
	^ self policyNamed: 'isVisible'
]

{ #category : #accessing }
LuiComponentPolicies >> parent [
	^ parent
]

{ #category : #accessing }
LuiComponentPolicies >> parent: anObject [
	parent := anObject
]

{ #category : #asking }
LuiComponentPolicies >> parentComponent [
	^ self parent
]

{ #category : #initialize }
LuiComponentPolicies >> policies [
	^ policies
]

{ #category : #initialize }
LuiComponentPolicies >> policies: anObject [ 
	policies := Dictionary new
]

{ #category : #'as yet unclassified' }
LuiComponentPolicies >> policyNamed: aString [
	^ self policies at: aString ifAbsent: [
		LuiComponentPropertyNotFound signal: ('Policy ' , aString , ' not defined for ' , self fullComponentNameWithId)]
]
