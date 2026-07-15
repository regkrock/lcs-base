Class {
	#name : 'LuiDependentComponentsDecoration',
	#superclass : 'LuiComponentDecoration',
	#category : 'Lcs-WebComponents-Decorations',
	#package : 'Lcs-WebComponents',
	#tag : 'Decorations'
}

{ #category : 'constants' }
LuiDependentComponentsDecoration class >> decorationName [
	^ 'dependentComponents'
]

{ #category : 'collection' }
LuiDependentComponentsDecoration >> addDependentComponent: aLuiComponent [
	self cachedValue add: aLuiComponent
]

{ #category : 'decoration' }
LuiDependentComponentsDecoration >> dependentComponents [
	^ self cachedValue
]

{ #category : 'decoration' }
LuiDependentComponentsDecoration >> dependentComponents: aString [
	self valueBlock: [ aString ]
]

{ #category : 'initialize' }
LuiDependentComponentsDecoration >> initialize [
	super initialize.
	self dependentComponents: OrderedCollection new
]

{ #category : 'collection' }
LuiDependentComponentsDecoration >> removeDependentComponent: aLuiComponent [
	self cachedValue remove: aLuiComponent ifAbsent: []
]
