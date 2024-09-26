Class {
	#name : #LuiComponentPolicy,
	#superclass : #Object,
	#instVars : [
		'policyName',
		'parent'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance  creation' }
LuiComponentPolicy class >> on: aComponentPolicies [
	^ self new 
		initializeOn: aComponentPolicies;
		yourself
]

{ #category : #'as yet unclassified' }
LuiComponentPolicy >> component [
	^ self parent component
]

{ #category : #initialize }
LuiComponentPolicy >> initializeOn: aComponentPolicies [ 
	self parent: aComponentPolicies
]

{ #category : #accessing }
LuiComponentPolicy >> parent [
	^ parent
]

{ #category : #accessing }
LuiComponentPolicy >> parent: aComponentPolicies [
	parent := aComponentPolicies
]

{ #category : #accessing }
LuiComponentPolicy >> policyName [
	^ policyName
]

{ #category : #accessing }
LuiComponentPolicy >> policyName: anObject [
	policyName := anObject
]
