Class {
	#name : #LuiRenderingProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constant }
LuiRenderingProperty class >> propertyName [
	^ 'Renderable'
]

{ #category : #command }
LuiRenderingProperty >> beNotRendereed [
	self valueBlock: [ false ]
]

{ #category : #command }
LuiRenderingProperty >> beRendered [
	self valueBlock: [ true ]
]

{ #category : #'as yet unclassified' }
LuiRenderingProperty >> initialize [
	super initialize.
	self valueBlock: [ true ]
]

{ #category : #'as yet unclassified' }
LuiRenderingProperty >> isNotRenderable [
	^ self isRenderable not
]

{ #category : #'as yet unclassified' }
LuiRenderingProperty >> isRenderable [
	^ self propertyValue = true 
]
