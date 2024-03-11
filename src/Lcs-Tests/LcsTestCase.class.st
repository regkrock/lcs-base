Class {
	#name : #LcsTestCase,
	#superclass : #TestCase,
	#instVars : [
		'savedSystem'
	],
	#category : #'Lcs-Tests'
}

{ #category : #accessing }
LcsTestCase >> currentSystem [
	^ LcsSystemManager currentSystem
]

{ #category : #accessing }
LcsTestCase >> currentUnitOfWork [
	^ self currentSystem currentUnitOfWork
]

{ #category : #accessing }
LcsTestCase >> savedSystem [
	^ savedSystem
]

{ #category : #accessing }
LcsTestCase >> savedSystem: anObject [
	savedSystem := anObject
]

{ #category : #running }
LcsTestCase >> setUp [
	super setUp.
	self savedSystem: LcsSystemManager currentSystem.
	LcsSystemManager clearCurrentSystem.
]

{ #category : #running }
LcsTestCase >> tearDown [
	super tearDown.
	LcsSystemManager currentSystem: self savedSystem
]