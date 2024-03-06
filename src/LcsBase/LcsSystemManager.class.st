Class {
	#name : #LcsSystemManager,
	#superclass : #LcsObject,
	#category : #LcsBase
}

{ #category : #accessing }
LcsSystemManager class >> clearCurrentSystem [
	self currentSystem: nil
]

{ #category : #accessing }
LcsSystemManager class >> createNewPrototypeSystem [
	self currentSystem: LxxPrototypeSystem newSystem
]

{ #category : #accessing }
LcsSystemManager class >> createNewSystem [
	^ LcsSystem newSystem
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem [
	^ LcsSmalltalkConfiguration systemDictionary at: #LcsCurrentSystemInstance ifAbsent: [nil]
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem: anLcsBaseSystem [
	LcsSmalltalkConfiguration systemDictionary at: #LcsCurrentSystemInstance put: anLcsBaseSystem
]
