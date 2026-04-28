Class {
	#name : 'LcsSystemAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'properties'
	],
	#category : 'LcsBase-Announcements',
	#package : 'LcsBase',
	#tag : 'Announcements'
}

{ #category : 'properties' }
LcsSystemAnnouncement >> properties [

	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : 'properties' }
LcsSystemAnnouncement >> propertyAt: aString ifAbsent: aBlockClosure [

	properties ifNil: [ ^ nil ].
	^ properties at: aString ifAbsent: aBlockClosure
]

{ #category : 'properties' }
LcsSystemAnnouncement >> propertyAt: aString ifPresent: aBlockClosure [

	properties ifNil: [ ^ self ].
	^ properties at: aString ifPresent: aBlockClosure
]

{ #category : 'properties' }
LcsSystemAnnouncement >> propertyAt: aKey put: aValue [

	self properties at: aKey put: aValue
]

{ #category : 'accessing' }
LcsSystemAnnouncement >> systemName [
	self propertyAt: 'name' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
LcsSystemAnnouncement >> systemName: aString [
	self propertyAt: 'name' put: aString
]
