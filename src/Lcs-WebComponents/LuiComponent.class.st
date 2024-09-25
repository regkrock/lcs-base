Class {
	#name : #LuiComponent,
	#superclass : #WAComponent,
	#instVars : [
		'components'
	],
	#category : #'Lcs-WebComponents'
}

{ #category : #accessing }
LuiComponent >> components [
	^ components
]

{ #category : #accessing }
LuiComponent >> components: anObject [
	components := anObject
]

{ #category : #'as yet unclassified' }
LuiComponent >> initialize [
	super initialize.
	self components: OrderedDictionary new.
]
