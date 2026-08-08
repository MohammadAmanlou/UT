import matplotlib
matplotlib.use('TkAgg')
from math import ceil
import os
import shutil
import matplotlib.pyplot as plt

cwndDict04 = {"newreno": [0] * 1001, "vegas": [0] * 1001, "tahoe": [0] * 1001}
cwndDict15 = {"newreno": [0] * 1001, "vegas": [0] * 1001, "tahoe": [0] * 1001}
goodputDict04 = {"newreno": [0] * 1001, "vegas": [0] * 1001, "tahoe": [0] * 1001}
goodputDict15 = {"newreno": [0] * 1001, "vegas": [0] * 1001, "tahoe": [0] * 1001}
rttDict04 = {"newreno": [0] * 1001, "vegas": [0] * 1001, "tahoe": [0] * 1001}
rttDict15 = {"newreno": [0] * 1001, "vegas": [0] * 1001, "tahoe": [0] * 1001}
lostDict04 = {"newreno": [0] * 1001, "vegas": [0] * 1001, "tahoe": [0] * 1001}
lostDict15 = {"newreno": [0] * 1001, "vegas": [0] * 1001, "tahoe": [0] * 1001}

def splitFile(filename):
	lines = []
	file = open(filename, 'r')
	line = file.readline()
	while line:
		lines.append(line.split())
		line = file.readline()
	return lines

def adjustArray(arr, defaultVal):
	for i in range(len(arr)):
		if arr[i] == defaultVal:
			arr[i] = arr[i-1] if i != 0 else 0
	return arr

def splitCWND(data):
	cwnds04 = [-1] * 1001
	cwnds15 = [-1] * 1001
	for line in data:
		if 'cwnd_' in line:
			if line[1] == '0':
				cwnds04[ceil(float(line[0]))] = float(line[6])
			else:
				cwnds15[ceil(float(line[0]))] = float(line[6])
	return adjustArray(cwnds04, -1), adjustArray(cwnds15, -1)

def splitAcks(data):
	acks04 = ['none'] * 1001
	acks15 = ['none'] * 1001
	for line in data:
		if 'ack_' in line:
			if line[1] == '0':
				acks04[ceil(float(line[0]))] = int(line[-1])
			else:
				acks15[ceil(float(line[0]))] = int(line[-1])
	return adjustArray(acks04, 'none'), adjustArray(acks15, 'none')

def splitLost(data):
	lost04 = [-1] * 1001
	lastLost04 = 0
	lost15 = [-1] * 1001
	lastLost15 = 0
	for line in data:
		if line[0] == 'd':
			if line[-4][0] == '0':
				lastLost04 += 1
				lost04[ceil(float(line[1]))] = lastLost04
			elif line[-4][0] == '1':
				lastLost15 += 1
				lost15[ceil(float(line[1]))] = lastLost15
	return adjustArray(lost04, -1), adjustArray(lost15, -1)

def splitRtt(data):
	rtt04 = [-1] * 1001
	rtt15 = [-1] * 1001
	for line in data:
		if 'rtt_' in line:
			if line[1] == '0':
				rtt04[ceil(float(line[0]))] = float(line[-1])
			else:
				rtt15[ceil(float(line[0]))] = float(line[-1])
	return adjustArray(rtt04, -1), adjustArray(rtt15, -1)

def addCwndDatas(newRenoData, vegasData, tahoeData):
	global cwndDict04, cwndDict15
	newrenoCwnds04, newrenoCwnds15 = splitCWND(newRenoData)
	vegasCwnds04, vegasCwnds15 = splitCWND(vegasData)
	tahoeCwnds04, tahoeCwnds15 = splitCWND(tahoeData)

	for i in range(1001):
		cwndDict04['newreno'][i] += newrenoCwnds04[i]
		cwndDict04['vegas'][i] += vegasCwnds04[i]
		cwndDict04['tahoe'][i] += tahoeCwnds04[i]
		cwndDict15['newreno'][i] += newrenoCwnds15[i]
		cwndDict15['vegas'][i] += vegasCwnds15[i]
		cwndDict15['tahoe'][i] += tahoeCwnds15[i]

def addGoodputDatas(newRenoData, vegasData, tahoeData):
	global goodputDict04, goodputDict15
	newrenoGoodputs04, newrenoGoodputs15 = splitAcks(newRenoData)
	vegasGoodputs04, vegasGoodputs15 = splitAcks(vegasData)
	tahoeGoodputs04, tahoeGoodputs15 = splitAcks(tahoeData)

	for i in range(1001):
		goodputDict04['newreno'][i] += newrenoGoodputs04[i]
		goodputDict04['vegas'][i] += vegasGoodputs04[i]
		goodputDict04['tahoe'][i] += tahoeGoodputs04[i]
		goodputDict15['newreno'][i] += newrenoGoodputs15[i]
		goodputDict15['vegas'][i] += vegasGoodputs15[i]
		goodputDict15['tahoe'][i] += tahoeGoodputs15[i]


def addRttDatas(newRenoData, vegasData,tahoeData):
	global rttDict04, rttDict15
	newrenoRtts04, newrenoRtts15 = splitRtt(newRenoData)
	vegasRtts04, vegasRtts15 = splitRtt(vegasData)
	tahoeRtts04, tahoeRtts15 = splitRtt(tahoeData)

	for i in range(1001):
		rttDict04['newreno'][i] += newrenoRtts04[i]
		rttDict04['vegas'][i] += vegasRtts04[i]
		rttDict04['tahoe'][i] += tahoeRtts04[i]
		rttDict15['newreno'][i] += newrenoRtts15[i]
		rttDict15['vegas'][i] += vegasRtts15[i]
		rttDict15['tahoe'][i] += tahoeRtts15[i]

def addLostDatas(newRenoData, vegasData, tahoeData):
        global lostDict04, lostDict15
        newrenoLosts04, newrenoLosts15 = splitLost(newRenoData)
        vegasLosts04, vegasLosts15 = splitLost(vegasData)
        tahoeLosts04, tahoeLosts15 = splitLost(tahoeData)

        for i in range(1001):
                lostDict04['newreno'][i] += newrenoLosts04[i]
                lostDict04['vegas'][i] += vegasLosts04[i]
                lostDict04['tahoe'][i] += tahoeLosts04[i]
                lostDict15['newreno'][i] += newrenoLosts15[i]
                lostDict15['vegas'][i] += vegasLosts15[i]
                lostDict15['tahoe'][i] += tahoeLosts15[i]

def runOneEpoch(i):
	os.system("ns newrenoCode.tcl")
	os.system("ns vegasCode.tcl")
	os.system("ns tahoeCode.tcl")

	newRenoData = splitFile('newrenoTrace.tr')
	vegasData = splitFile('vegasTrace.tr')
	tahoeData = splitFile('tahoeTrace.tr')

	addCwndDatas(newRenoData, vegasData, tahoeData)
	addGoodputDatas(newRenoData, vegasData, tahoeData)
	addRttDatas(newRenoData, vegasData, tahoeData)
	addLostDatas(newRenoData, vegasData, tahoeData)

	if not os.path.exists('./results'):
		os.makedirs('./results')

	folder_name = os.path.join('./results', str(i))
	if not os.path.exists(folder_name):
		os.makedirs(folder_name)

	shutil.move('newrenoTrace.tr', os.path.join(folder_name, 'newrenoTrace.tr'))
	shutil.move('vegasTrace.tr', os.path.join(folder_name, 'vegasTrace.tr'))
	shutil.move('tahoeTrace.tr', os.path.join(folder_name, 'tahoeTrace.tr'))
	shutil.move('newreno.nam', os.path.join(folder_name, 'newreno.nam'))
	shutil.move('vegas.nam', os.path.join(folder_name, 'vegas.nam'))
	shutil.move('tahoe.nam', os.path.join(folder_name, 'tahoe.nam'))

def calcAvgVars():
	global cwndDict04, cwndDict15, goodputDict04, goodputDict15
	for key in cwndDict04.keys():
		for i in range(1001):
			cwndDict04[key][i] /= 10
			cwndDict15[key][i] /= 10
			goodputDict04[key][i] /= 10
			goodputDict15[key][i] /= 10
			rttDict04[key][i] /= 10
			rttDict15[key][i] /= 10
			lostDict04[key][i] /= 10
			lostDict15[key][i] /= 10

def run():
	for i in range(10):
		print("Number " + str(i+1) + " :")
		runOneEpoch(i+1)
	calcAvgVars()

def analyzeCWND():
	global cwndDict04, cwndDict15
	colors = ['c', 'm', 'y', 'g', 'b', 'r']
	for key in cwndDict04.keys():
		plt.plot(range(1001), cwndDict04[key], label=key+"04", c = colors[-1])
		colors.pop()
		plt.plot(range(1001), cwndDict15[key], label=key+"15", c = colors[-1])
		colors.pop()
	plt.xlabel("time")
	plt.ylabel("CWND")
	plt.title("CWND per second")
	plt.legend()
	plt.show()

def derivative(arr):
	arr2 = [0] * len(arr)
	for i in range(1, len(arr)):
		arr2[i] = arr[i]/i
	arr2[0] = arr[0]
	return arr2

def difference(arr):
	arr2 = [0] * len(arr)
	for i in range(1, len(arr)):
		arr2[i] = arr[i] - arr[i-1]
	arr2[0] = arr[0]
	return arr2

def analyzeGoodput():
	global goodputDict04, goodputDict15
	colors = ['c', 'm', 'y', 'g', 'b', 'r']
	for key in goodputDict04.keys():
		plt.plot(range(1001), derivative(goodputDict04[key]), label=key+"04", c = colors[-1])
		colors.pop()
		plt.plot(range(1001), derivative(goodputDict15[key]), label=key+"15", c = colors[-1])
		colors.pop()
	plt.xlabel("time")
	plt.ylabel("Goodput rate")
	plt.title("Goodput rate per second")
	plt.legend()
	plt.show()

def analyzeRtt():
	global rttDict04, rttDict15
	colors = ['c', 'm', 'y', 'g', 'b', 'r']
	for key in rttDict04.keys():
		plt.plot(range(1001), rttDict04[key], label=key+"04", c = colors[-1])
		colors.pop()
		plt.plot(range(1001), rttDict15[key], label=key+"15", c = colors[-1])
		colors.pop()
	plt.xlabel("time")
	plt.ylabel("RTT rate")
	plt.title("RTT rate per second")
	plt.legend()
	plt.show()

def analyzeLost():
	global lostDict04, lostDict15
	colors = ['c', 'm', 'y', 'g', 'b', 'r']
	for key in lostDict04.keys():
		plt.plot(range(1001), derivative(lostDict04[key]), label=key+"04", c = colors[-1])
		colors.pop()
		plt.plot(range(1001), derivative(lostDict15[key]), label=key+"15", c = colors[-1])
		colors.pop()
	plt.xlabel("time")
	plt.ylabel("Packet loss rate")
	plt.title("Packet loss rate per second")
	plt.legend()
	plt.show()

run()
analyzeCWND()
analyzeGoodput()
analyzeRtt()
analyzeLost()
