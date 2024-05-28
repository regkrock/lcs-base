Class {
	#name : #GtListAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'items',
		'compute'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Object Advices'
}

{ #category : #accessing }
GtListAdvice >> compute [
	^ compute
]

{ #category : #accessing }
GtListAdvice >> compute: arg1 [
	compute := arg1
]

{ #category : #testing }
GtListAdvice >> hasAdvice [
	^ self result notEmpty
]

{ #category : #initialization }
GtListAdvice >> initialize [
	super initialize.
	compute := [ #() ]
]

{ #category : #accessing }
GtListAdvice >> result [
	^ items ifNil: [ items := compute value ] ifNotNil: [ items ]
]

{ #category : #enumerating }
GtListAdvice >> resultsDo: arg1 [
	self result do: arg1
]
