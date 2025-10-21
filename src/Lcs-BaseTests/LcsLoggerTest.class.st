Class {
	#name : #LcsLoggerTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-BaseTests-Tests'
}

{ #category : #tests }
LcsLoggerTest >> testCreation [
	| aLogger |
	aLogger := LcsLogger new.
	self assert: (aLogger stream class = NullStream).
	self assert: aLogger tabLevel equals: 0
]

{ #category : #tests }
LcsLoggerTest >> testIndentAndOutdent [
	| aLogger |
	aLogger := LcsLogger new.
	self assert: (aLogger stream class = NullStream).
	self assert: aLogger tabLevel equals: 0.
	aLogger indent.
	self assert: aLogger tabLevel equals: 1.
	aLogger indent.
	self assert: aLogger tabLevel equals: 2.
	aLogger outdent.
	self assert: aLogger tabLevel equals: 1.
	aLogger outdent.
	self assert: aLogger tabLevel equals: 0.
	aLogger outdent.
	self assert: aLogger tabLevel equals: 0.
	aLogger outdent.
	self assert: aLogger tabLevel equals: 0.
]

{ #category : #tests }
LcsLoggerTest >> testLogginOff [
	| aLogger |
	aLogger := LcsLogger new.
	self assert: (aLogger stream class = NullStream).
	aLogger streamLoggingOn.
	self assert: (aLogger stream class = WriteStream).
	aLogger loggingOff.
	self assert: (aLogger stream class = NullStream)
]

{ #category : #tests }
LcsLoggerTest >> testReset [
	| aLogger |
	aLogger := LcsLogger new.
	self assert: (aLogger stream class = NullStream).
	self assert: aLogger tabLevel equals: 0.
	aLogger indent.
	aLogger indent.
	self assert: aLogger tabLevel equals: 2.
	aLogger reset.
	self assert: aLogger tabLevel equals: 0
]

{ #category : #tests }
LcsLoggerTest >> testResetTranscript [
	| aLogger |
	aLogger := LcsLogger new.
	aLogger transcriptLoggingOn.
	self assert: (aLogger stream isStream not).
	self assert: aLogger tabLevel equals: 0.
	aLogger indent.
	aLogger indent.
	self assert: aLogger tabLevel equals: 2.
	aLogger reset.
	self assert: aLogger tabLevel equals: 0
]

{ #category : #tests }
LcsLoggerTest >> testSwitchingToStreamLogging [
	| aLogger |
	aLogger := LcsLogger new.
	aLogger streamLoggingOn.
	self assert: (aLogger stream class = WriteStream).
]

{ #category : #tests }
LcsLoggerTest >> testSwitchingToTranscriptLogging [
	| aLogger |
	aLogger := LcsLogger new.
	aLogger transcriptLoggingOn.
	self assert: (aLogger stream = Transcript).
]
