Class {
	#name : 'LcsCalendarEventExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-CalendarTests-Examples',
	#package : 'Lcs-CalendarTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsCalendarEventExamples >> newEvent [
	<gtExample>
	<after: #clearUnitOfWork>
	| event endDayOfMonth endHour |
	self ensureCurrentSystemIsDemoSystem.
	event := LcsCalendarEvent new.
	self assert: (event effective isKindOf: DateAndTime).
	self assert: (event expiry isKindOf: DateAndTime).
	self assert: event effective < event expiry.
	self assert: event effective year equals: event expiry year.
	self assert: event effective month equals: event expiry month.
	(Time now hour = 23) 
		ifTrue: [ 
			endDayOfMonth := event effective dayOfMonth + 1.
			endHour := 0 ] 
		ifFalse: [ 
			endDayOfMonth := event effective dayOfMonth.
			endHour := event effective hour + 1].
	self assert:endDayOfMonth = event expiry dayOfMonth.
	self assert: endHour equals: event expiry hour.
	self assert: event effective minute equals: event expiry minute.
	self assert: event effective minute equals: 0.
	self assert: event effective seconds equals: 0.
	self assert: event title equals: ''.
	self assert: event description equals: ''.
	self should: [ event description: 123 ] raise: LcsError.
	^ event
]
