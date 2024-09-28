Class {
	#name : #LuiVisibilityPolicy,
	#superclass : #LuiComponentPolicy,
	#instVars : [
		'visibleBlock'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #defaults }
LuiVisibilityPolicy >> defaultBlock [
	^ [ true ]
]

{ #category : #'as yet unclassified' }
LuiVisibilityPolicy >> initialize [
	self evaluationBlock: self defaultBlock.
	self policyName: 'isVisible'
]

{ #category : #'as yet unclassified' }
LuiVisibilityPolicy >> isHidden [
	^ self isVisible not
]

{ #category : #'as yet unclassified' }
LuiVisibilityPolicy >> isVisible [
	^ self evaluationBlock cull: self component
]

{ #category : #accessing }
LuiVisibilityPolicy >> visibleBlock [
	^ visibleBlock
]

{ #category : #'as yet unclassified' }
LuiVisibilityPolicy >> visibleBlock: aBlock [
	visibleBlock := aBlock 
]
