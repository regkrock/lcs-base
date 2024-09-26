Class {
	#name : #LuiVisibilityPolicy,
	#superclass : #LuiComponentPolicy,
	#instVars : [
		'visibleBlock'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'as yet unclassified' }
LuiVisibilityPolicy >> initialize [
	self visibleBlock: [ true ]
]

{ #category : #'as yet unclassified' }
LuiVisibilityPolicy >> isHidden [
	^ self isVisible not
]

{ #category : #'as yet unclassified' }
LuiVisibilityPolicy >> isVisible [
	^ self visibleBlock cull: self component
]

{ #category : #accessing }
LuiVisibilityPolicy >> visibleBlock [
	^ visibleBlock
]

{ #category : #'as yet unclassified' }
LuiVisibilityPolicy >> visibleBlock: aBlock [
	self visibleBlock: aBlock 
]
