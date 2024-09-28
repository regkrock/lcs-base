Class {
	#name : #LuiComponentPolicy,
	#superclass : #Object,
	#instVars : [
		'policyName',
		'parent',
		'evaluationBlock'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance  creation' }
LuiComponentPolicy class >> on: aComponentPolicies [
	^ self new 
		initializeOn: aComponentPolicies;
		yourself
]

{ #category : #component }
LuiComponentPolicy >> component [
	^ self parent parent
]

{ #category : #defaults }
LuiComponentPolicy >> defaultBlock [
	^ [ ]
]

{ #category : #accessing }
LuiComponentPolicy >> evaluationBlock [
	^ evaluationBlock
]

{ #category : #accessing }
LuiComponentPolicy >> evaluationBlock: anObject [
	evaluationBlock := anObject
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
