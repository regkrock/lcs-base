Class {
	#name : #GtAsyncStreamAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'compute',
		'stream'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Object Advices'
}

{ #category : #accessing }
GtAsyncStreamAdvice >> compute [
	^ compute
]

{ #category : #accessing }
GtAsyncStreamAdvice >> compute: arg1 [
	compute := arg1
]

{ #category : #testing }
GtAsyncStreamAdvice >> hasAdvice [
	^ self result hasNext wait
]

{ #category : #initialization }
GtAsyncStreamAdvice >> initialize [
	super initialize.
	compute := [ #() asAsyncStream ]
]

{ #category : #accessing }
GtAsyncStreamAdvice >> result [
	stream ifNil: [ stream := compute value cached ].
	^ stream asyncSimilarCopy
]

{ #category : #enumerating }
GtAsyncStreamAdvice >> resultsDo: arg1 [
	(self result do: arg1) wait
]
