Class {
	#name : #LcsSystemManager,
	#superclass : #LcsObject,
	#category : #LcsBase
}

{ #category : #accessing }
LcsSystemManager class >> createNewSystem [
	self currentSystem: LcsSystem newSystem
]

{ #category : #accessing }
LcsSystemManager class >> createNewTestSystem [
	self currentSystem: LcsTestSystem newSystem
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem [
	^ LcsSmalltalkConfiguration systemDictionary at: #LcsCurrentSystemInstance ifAbsent: [nil]
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem: anLcsBaseSystem [
	LcsSmalltalkConfiguration systemDictionary at: #LcsCurrentSystemInstance put: anLcsBaseSystem
]
