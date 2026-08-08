#include <stdio.h>

struct rtpkt
{
  int sourceid;   /* id of sending router sending this pkt */
  int destid;     /* id of router to which pkt being sent
                     (must be an immediate neighbor) */
  int mincost[4]; /* min cost to node 0 ... 3 */
};


extern int TRACE;
extern int YES;
extern int NO;
extern float clocktime;
#define INFINITY 999

struct distance_table
{
  int costs[4][4];
} dt1;

void printdt1(struct distance_table *dtptr);
void tolayer2(struct rtpkt pkt);

int direct_costs1[4] = {1, 0, 1, 999};
static int neighbor_reported_costs[4][4];

int get_min_cost1(int dest)
{
  if (dest == 1)
    return 0;
  int min = INFINITY;

  int neighbors[] = {0, 2};
  for (int k = 0; k < 2; k++)
  {
    int neighbor = neighbors[k];

    int cost = dt1.costs[dest][neighbor];

    if (cost < min)
      min = cost;
  }
  return min;
}

void send_dt1_to_neighbors()
{
  struct rtpkt pkt;
  pkt.sourceid = 1;

  for (int i = 0; i < 4; i++)
  {
    pkt.mincost[i] = get_min_cost1(i);
  }

  if (TRACE > 0)
    printf("t=%.3f node1: sending [%d, %d, %d, %d] to neighbors.\n",
           clocktime, pkt.mincost[0], pkt.mincost[1], pkt.mincost[2], pkt.mincost[3]);

  int neighbors[] = {0, 2};
  for (int i = 0; i < 2; i++)
  {
    pkt.destid = neighbors[i];
    tolayer2(pkt);
  }
}

void rtinit1()
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      dt1.costs[i][j] = INFINITY;
      neighbor_reported_costs[i][j] = INFINITY;
    }
  }

  dt1.costs[0][0] = direct_costs1[0];
  dt1.costs[2][2] = direct_costs1[2];

  neighbor_reported_costs[1][0] = INFINITY;
  neighbor_reported_costs[0][0] = 0;
  neighbor_reported_costs[1][2] = INFINITY;
  neighbor_reported_costs[2][2] = 0;

  printf("t=%.3f rtinit1: table initialized.\n", clocktime);
  printdt1(&dt1);

  send_dt1_to_neighbors();
}

void rtupdate1(rcvdpkt) struct rtpkt *rcvdpkt;
{
  int src = rcvdpkt->sourceid;
  int changed = 0;

  int old_min_costs[4];
  for (int i = 0; i < 4; i++)
    old_min_costs[i] = get_min_cost1(i);

  for (int i = 0; i < 4; i++)
  {
    neighbor_reported_costs[i][src] = rcvdpkt->mincost[i];
  }

  for (int i = 0; i < 4; i++)
  {
    int new_cost = direct_costs1[src] + rcvdpkt->mincost[i];
    if (new_cost > INFINITY)
      new_cost = INFINITY;

    dt1.costs[i][src] = new_cost;
  }

  for (int i = 0; i < 4; i++)
  {
    if (get_min_cost1(i) != old_min_costs[i])
    {
      changed = 1;
      break;
    }
  }

  printf("t=%.3f rtupdate1: received [%d, %d, %d, %d] from node %d and mincosts %s\n",
         clocktime,
         rcvdpkt->mincost[0], rcvdpkt->mincost[1], rcvdpkt->mincost[2], rcvdpkt->mincost[3],
         src,
         changed ? "updated" : "did not update");

  printdt1(&dt1);

  if (changed)
  {
    send_dt1_to_neighbors();
  }
}

void printdt1(dtptr) struct distance_table *dtptr;

{
  printf("             via   \n");
  printf("   D1 |    0     2 \n");
  printf("  ----|-----------\n");
  printf("     0|  %3d   %3d\n", dtptr->costs[0][0], dtptr->costs[0][2]);
  printf("dest 2|  %3d   %3d\n", dtptr->costs[2][0], dtptr->costs[2][2]);
  printf("     3|  %3d   %3d\n", dtptr->costs[3][0], dtptr->costs[3][2]);
}

void linkhandler1(linkid, newcost) int linkid, newcost;
/* called when cost from 1 to linkid changes from current value to newcost*/
/* You can leave this routine empty if you're an undergrad. If you want */
/* to use this routine, you'll need to change the value of the LINKCHANGE */
/* constant definition in prog3.c from 0 to 1 */

{
  int old_min_costs[4];
  for (int i = 0; i < 4; i++)
    old_min_costs[i] = get_min_cost1(i);

  direct_costs1[linkid] = newcost;

  /* بازسازی ستون لینک تغییر یافته */
  for (int i = 0; i < 4; i++)
  {
    int cost_via_neighbor = neighbor_reported_costs[i][linkid];

    if (cost_via_neighbor == INFINITY)
    {
      dt1.costs[i][linkid] = INFINITY;
    }
    else
    {
      int total = newcost + cost_via_neighbor;
      if (total > INFINITY)
        total = INFINITY;
      dt1.costs[i][linkid] = total;
    }
  }

  int changed = 0;
  for (int i = 0; i < 4; i++)
  {
    if (get_min_cost1(i) != old_min_costs[i])
    {
      changed = 1;
      break;
    }
  }

  printf("t=%.3f linkhandler1: cost to link %d changed to %d. mincosts %s\n",
         clocktime, linkid, newcost, changed ? "updated" : "did not update");

  printdt1(&dt1);

  if (changed)
  {
    send_dt1_to_neighbors();
  }
}
